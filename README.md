# Online-Video-KYC-SC
[App apk link]https://drive.google.com/file/d/168KVLr6nMv8p7uBxAweijhMXuUItcqyt/view?usp=sharing

[Demo Link]https://drive.google.com/drive/folders/10ZevU4jsO1Lgu442_8y0uVbJNYa6hZLv?usp=drive_link
# App Flow

## 1. Launch Screen
- The app displays the Standard Chartered icon when launched.
![image](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/d5338bd4-531c-49ed-9dc8-41474bd42a19)


## 2. Account Creation Screen
- After launching the app, the user is directed to a screen with a button to create an account for Know Your Customer (KYC) purposes.
![image](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/66a59772-02f6-4b7d-afc4-b0d3437a5852)


## 3. Login Screen
- Upon tapping the button on the account creation screen, the user is navigated to a login page where they can enter their email ID.
- Additionally, there will be a mechanism for email verification, and an OTP (One-Time Password) is sent to the user's email for verification.
![image](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/2d990c44-b9aa-492a-a855-8a04e59aebe5)

## 4. KYC Information Entry Screen
- Once the user successfully logs in, they are directed to a screen where they can enter their KYC information.
- This screen includes text fields for entering Aadhar card number, PAN card number, and date of birth (DOB).
- The user is required to upload images of their Aadhar card front and back, PAN card front and back, and a passport size photo.
  ![aadhar1](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/8a1ec5a6-611c-4059-90ad-5f28cba9876c)
  ![aadhar2](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/8a58cfc8-5375-4132-9c0f-61bab7f875bc)
  ![PAN1](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/ee441cf5-9c0b-4935-8a3e-657674c29e12)
  ![PAN2](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/39195afd-b009-4cb6-af76-bc85d58e5001)




## 5. Video KYC Screen
- After entering KYC information and uploading documents, the user proceeds to a video KYC (Know Your Customer) process.
- During the video KYC, the user is prompted to display their Aadhar card, PAN card, and passport size photo to the camera.
- Random snapshots of the user's face are taken to compare with their passport size photo and verify their identity.
- The images captured during the video KYC are verified with the backend database in real-time using Firebase.
- Upon successful verification, the border of the video KYC screen is highlighted with a green color, indicating completion.
  ![Permissions](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/5aedaf7c-7fb0-4078-85f3-7c9ab8079fd0)
  ![Video_KYC](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/4f20f216-1365-43f1-a93b-f113fa8fbd75)
  ![Digital_signature](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/4ad22556-1a25-4f31-bf41-e3b248ed9d76)
  ![Permissions](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/5959cbfc-f046-48b8-9315-0fe7a40e05aa)

  ![Verification](https://github.com/zeelsheth2003/Online-Video-KYC-SC/assets/103491971/36c4f004-b38f-415e-8ea7-557a3ba38df9)




## App Working:

- **Email Verification:** Upon entering the email ID, an OTP is sent to the user's email for verification.
- **Aadhar and PAN Verification:** The user-provided Aadhar card number is verified with the backend database in real-time using Firebase.
- **Passport Size Image Comparison:** The user's passport size photo is compared with the captured photo using OpenCV. If the images are below a certain threshold level and mean square error, they are considered identical.
- **Video KYC AI Proctoring:** During the video KYC process, the user's identity is verified by comparing the snapshots of their face with their passport size photo. Additionally, the images of documents displayed by the user are verified with the real-time Firebase database.
- **Blurred Image Detection:** We are developing a blurred image detection model using Support Vector Machine (SVM) to determine whether the image uploaded by the user is blurred or not.
The dataset used for blur image detection can be found [here](https://drive.google.com/drive/folders/1B9Lo0Vs5bpX6RiI2AJN2fpK1VcBDpeMz?usp=sharing).
- **Success Confirmation:** If all verification steps are successful, a green tick mark is displayed, indicating the successful completion of the video KYC process.

