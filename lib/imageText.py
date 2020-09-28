import pytesseract

from PIL import Image

img=Image.open('quote.png')
text=pytesseract.image_to_string(img,lang = 'eng')
print(text)
# print(tessaract.GetBoxText())
utter ble
