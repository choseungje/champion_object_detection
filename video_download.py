import argparse
from pytube import YouTube

args = argparse.ArgumentParser()
args.add_argument("--url", type=str)
args = args.parse_args()

DOWNLOAD_FOLDER = "./"

yt = YouTube(args.url)

streams_list = []

for i in yt.streams:
    if '1080p' in str(i) and '60fps' in str(i):
        streams_list.append(i)

stream = streams_list[0]
print("DownLoad :", stream)
stream.download(DOWNLOAD_FOLDER, filename="download_video.mp4")
print("Done.")
