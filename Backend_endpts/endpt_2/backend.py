from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
import cv2
import numpy as np

app = FastAPI()

def mse(img1, img2):
    diff = img1 - img2
    mse = np.mean(diff ** 2)
    return mse


@app.post("/calculate_mse/")
async def calculate_mse(image1: UploadFile = File(...), image2: UploadFile = File(...)):
    contents1 = await image1.read()
    contents2 = await image2.read()
    nparr1 = np.frombuffer(contents1, np.uint8)
    nparr2 = np.frombuffer(contents2, np.uint8)
    img1 = cv2.imdecode(nparr1, cv2.IMREAD_GRAYSCALE)
    img2 = cv2.imdecode(nparr2, cv2.IMREAD_GRAYSCALE)
    img2_resized = cv2.resize(img2, (img1.shape[1], img1.shape[0]))
    error = mse(img1, img2_resized)
    return JSONResponse(content={"mse_score": error})
