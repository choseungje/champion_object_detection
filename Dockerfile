FROM pytorch/pytorch:1.9.1-cuda11.1-cudnn8-runtime

COPY ./yolov5/requirements.txt requirements.txt
RUN pip install -r requirements.txt && \
    pip install tqdm && \
    apt-get update && apt-get install -y --no-install-recommends libgl1-mesa-glx libglib2.0-0    
