#!/bin/bash
set -e
cd "$(dirname "$0")"
FF=/opt/homebrew/bin/ffmpeg
FP=/opt/homebrew/bin/ffprobe
FPS=30
mkdir -p frames clips2 work
BASE="$(pwd)"

shot=(01_promo 02_path 03_node 04_training 05_star 06_concept 07_more 01_promo)
title=("PolApex 政治登顶" "登顶之路 · 28关" "每个考点 · 深度讲透" "答案工厂 · 提分闭环" "概念星图 · 知识成网" "点开节点 · 直达高分句" "智能复习 + 武器库" "PolApex 政治登顶")
sub=(
$'高中政治：背了就忘、答题没思路？\n这一次，把政治变成实实在在的分数'
$'从初中打底到高考冲刺，一关一关闯\n进度、薄弱点、今日推荐一目了然'
$'必背原文 · 白话理解 · 答题模板\n易混辨析 · 高分答案句 · 扣分提醒'
$'按高考真实结构出题\n学 → 练 → 拆 → 复，错题自动复习'
$'按模块收纳，点开就是一张概念圆环\n谁包含谁、谁对比谁，一清二楚'
$'材料触发词 · 关系网络 · 深度讲解\n从关键词一路链到能抄进卷子的句子'
$'智能复习 · 学情诊断 · 选择题排雷\n主体矩阵 · 答案模板库，十多件武器'
$'从背诵到得分\n现在就开始你的登顶之路'
)
acc=("#F5732E" "#1FB6A6" "#E8534E" "#F5732E" "#3E86E6" "#E0A33A" "#7C6CF0" "#1FB6A6")
# 无旁白：手动定时长，留足阅读时间，节奏紧凑
durs=(4.4 4.8 5.4 5.0 5.0 5.0 5.4 4.6)

echo "=== 1) frames ==="
for i in 0 1 2 3 4 5 6 7; do
  swift render_scene.swift "frames/f$i.png" "shots/${shot[$i]}.png" "${title[$i]}" "${sub[$i]}" "${acc[$i]}" "$i" 8 >/dev/null
  echo "  f$i <- ${shot[$i]} / ${title[$i]}"
done

echo "=== 2) per-scene video clips (Ken Burns + dip-to-black) ==="
: > work/list.txt
for i in 0 1 2 3 4 5 6 7; do
  sd=${durs[$i]}
  N=$(printf "%.0f" "$(echo "$sd * $FPS" | bc -l)")
  INC=$(echo "0.10 / $N" | bc -l)
  fo=$(echo "$sd - 0.4" | bc -l)
  $FF -y -loop 1 -i frames/f$i.png \
    -filter_complex "[0:v]zoompan=z='min(zoom+$INC,1.10)':d=$N:s=1080x1920:fps=$FPS:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=0.4,fade=t=out:st=$fo:d=0.4,format=yuv420p[v]" \
    -map "[v]" -t "$sd" \
    -c:v libx264 -profile:v high -pix_fmt yuv420p -r $FPS -b:v 8M \
    clips2/c$i.mp4 >/dev/null 2>&1
  echo "file '$BASE/clips2/c$i.mp4'" >> work/list.txt
  echo "  c$i: ${sd}s"
done

echo "=== 3) concat -> silent master ==="
$FF -y -f concat -safe 0 -i work/list.txt \
  -c:v libx264 -profile:v high -pix_fmt yuv420p -r $FPS -b:v 8M \
  -movflags +faststart work/silent.mp4 >/dev/null 2>&1
VLEN=$($FP -v error -show_entries format=duration -of csv=p=0 work/silent.mp4)
echo "  video length = ${VLEN}s"

echo "=== 4) music mix ==="
MUSIC=$(ls music.* 2>/dev/null | head -1 || true)
if [ -n "$MUSIC" ]; then
  echo "  using music: $MUSIC"
  fo=$(echo "$VLEN - 1.5" | bc -l)
  $FF -y -i work/silent.mp4 -stream_loop -1 -i "$MUSIC" \
    -filter_complex "[1:a]volume=0.55,afade=t=in:st=0:d=1.0,afade=t=out:st=$fo:d=1.5[a]" \
    -map 0:v -map "[a]" -t "$VLEN" \
    -c:v copy -c:a aac -b:a 192k -ar 44100 -movflags +faststart \
    PolApex_介绍.mp4 >/dev/null 2>&1
  echo "  -> PolApex_介绍.mp4 (含背景音乐)"
else
  cp work/silent.mp4 PolApex_介绍.mp4
  echo "  ⚠ 未找到 music.*（mp3/m4a/wav），先输出无声版。把音乐放到 video_assets/music.mp3 再重跑即可。"
fi

echo "=== done ==="
$FP -v error -show_entries format=duration -of csv=p=0 PolApex_介绍.mp4
ls -la PolApex_介绍.mp4
