# LOL Champine Object_Detection
LOL 영상의 미니맵에서 챔피언들을 Object Detection 해서 json을 반환하도록 합니다.

**데이터 파이프라인은 아래와 같이 구성합니다.**
1. 훈련 데이터셋 생성
2. Youtube에서 mp4 다운로드
3. Object Detection Model Training
4. LOL champine Object Detection

**Object Detection 모델 훈련은 아래의 과정을 거쳐 데이터셋을 직접 만듭니다.**
* 롤 영상의 미니맵에서 챔피언 초상화를 추출하는 것이기 때문에, 미니맵 사진을 따로 만듭니다.
* 현재 10가지 챔피언의 초상화로만 훈련할 목적이기 때문에, 10가지 이외의 다른 챔피언은 Detection 하지 못합니다.
* 미니맵에서 초상화(탈론)의 형태가 바뀌는 것이 아닌, 위치만 움직이는 것이기 때문에 초상화가 미니맵에서 생길 수 있는 **분포가 한정**되어 있습니다.
* 따라서 미니맵에 랜덤하게 초상화를 위치시켜 합성하는 방법으로 데이터셋을 새롭게 만듭니다.

**빠른 Detection을 위해 YoloV5를 해당 Task에 적합하도록 수정해서 사용하였습니다.**

## ENV
단일 Docker Contanier를 사용하도록 합니다.

Docker image build
```shell
docker build -t lol_object_detection:latest -f Dockerfile .
```

Run Container
```shell
docker run --name lol -v ~/[path]/lol_object_detection:/workspace --shm-size=10gb --gpus '"device=0"' -it lol_object_detection:latest
```

## Download mp4
URL을 입력하면 1080x1920 60fps의 영상을 다운로드합니다.
```shell
python video_download.py --url [youtube url]
```

## Create Dataset
Object Detection 모델을 훈련할 Train Dataset을 생성합니다.
```shell
python data.py
```

---

## All Process
아래 command는 전체 Data Pipeline을 실행하도록 합니다.
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
전체 Data Pipeline의 결과는 아래의 path에서 확인할 수 있습니다.

```
runs/detect/exp
             |--download_video.mp4
             |--output.json
```
