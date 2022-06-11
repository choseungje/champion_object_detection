# lol_object_detection

## ENV

```shell
docker build -t lol_object_detection:latest -f Dockerfile .
```

```shell
docker run --name lol -v ~/[path]/lol_object_detection:/workspace --shm-size=10gb --gpus '"device=0"' -it lol_object_detection:latest
```

## Download mp4

```shell
python video_download.py --url [youtube url]
```

## Create Dataset

```shell
python data.py
```

---

## All Process

```shell
sh all_process.sh https://www.youtube.com/watch\?v\=HgIREYFDGg8
```

---

## Object Detection Model Training

```shell
cd yolov5
python train.py --img 640 --batch 128 --epoch 10 --data opgg.yaml --project ./
```

## Inference Video

```shell
cd yolov5
python detect.py --weights ./exp/weights/best.pt --source ../download_video.mp4 --conf 0.5 --data data/opgg.yaml --line-thickness 1
```

## Result

path

```
runs/detect/exp
             |--download_video.mp4
             |--output.json
```
