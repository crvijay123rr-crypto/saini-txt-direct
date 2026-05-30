FROM python:3.12-alpine3.20

WORKDIR /app

COPY . .

RUN apk add --no-cache gcc libffi-dev musl-dev ffmpeg aria2 make g++ cmake wget unzip

RUN wget -q https://github.com/axiomatic-systems/Bento4/archive/v1.6.0-639.zip && 
unzip v1.6.0-639.zip && 
cd Bento4-1.6.0-639 && 
mkdir build && 
cd build && 
cmake .. && 
make -j$(nproc) && 
cp mp4decrypt /usr/local/bin/ && 
cd ../.. && 
rm -rf Bento4-1.6.0-639 v1.6.0-639.zip

RUN pip install --no-cache-dir --upgrade pip setuptools wheel && 
pip install --no-cache-dir -r sainibots.txt && 
pip install --no-cache-dir -U yt-dlp

CMD ["python3", "modules/main.py"]
