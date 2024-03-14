import joblib
from fastapi import File, UploadFile, HTTPException, FastAPI
import cv2
import numpy as np
import matplotlib.pyplot as plt
import io
from fastapi.responses import Response
from fastapi.responses import JSONResponse


app = FastAPI()

def load_model(file_path):
    model = joblib.load(file_path)
    return model

model = load_model('model.pkl')
def is_blurry(image, model):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    laplacian = cv2.Laplacian(gray, cv2.CV_64F)
    img_features = [[laplacian.var(), np.amax(laplacian)]]
    prediction = model.predict(img_features)
    return bool(prediction[0] == 1)

@app.post("/predict/")
async def predict(image: UploadFile = File(...)):
    if not image.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Uploaded file is not an image")

    contents = await image.read()
    nparr = np.frombuffer(contents, np.uint8)
    img_np = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    blurry = is_blurry(img_np, model)

    fig, ax = plt.subplots()
    ax.imshow(cv2.cvtColor(img_np, cv2.COLOR_BGR2RGB))
    ax.set_title('Prediction: ' + ('Blurred Picture' if blurry else 'Clear Picture'))
    ax.axis('off')

    # Save the plot to a bytes buffer
    buffer = io.BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)
    plt.close()

    # Convert the plot buffer to bytes
    plot_bytes = buffer.getvalue()

    return JSONResponse(content={"blurry": blurry})
