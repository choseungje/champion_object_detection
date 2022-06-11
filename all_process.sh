#!/bin/bash
url=$1
echo "URL: $url"
python video_download.py --url $url
python data.py

cd yolov5
python train.py --img 640 --batch 128 --epoch 10 --data opgg.yaml --project ./
python detect.py --weights ./exp/weights/best.pt --source ../download_video.mp4 --conf 0.5 --data data/opgg.yaml --line-thickness 1
