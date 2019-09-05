import tensorflow
import argparse
import requests
import json
import numpy as np


parser = argparse.ArgumentParser()
parser.add_argument(
    '--image_path',
    type=str,
    default='/Users/anmy/Downloads/pic_temp/555.jpg',
    help='path of image'
)

parser.add_argument(
    '--label_file',
    type=str,
    default='/tmp/output_labels.txt',
    help='path of label file'
)

args = vars(parser.parse_args())

# Loading and pre-processing our input image
image_path = args['image_path']
img = tensorflow.keras.preprocessing.image.img_to_array(tensorflow.keras.preprocessing.image.load_img(image_path, target_size=(128, 128))) / 255.
img = np.expand_dims(img, axis=0)

# sending post request to TensorFlow Serving server
payload = {"instances": img.tolist()}
json_response = requests.post('http://localhost:8501/v1/models/saved_models:predict', json=payload)
pred = json.loads(json_response.content.decode('utf-8'))
# print(pred)

# create a list containing the class labels
class_labels = []
label_file = args['label_file']
proto_as_ascii_lines = tensorflow.gfile.GFile(label_file).readlines()
for l in proto_as_ascii_lines:
  class_labels.append(l.rstrip())

# get top k predictions
top_k = np.array(pred['predictions'])[0].argsort()[-5:][::-1]
print(top_k)
for k in top_k:
  print(k, '-', class_labels[k])

# find the index of the class with maximum score, and print the label of the class with maximum score
# pred = np.argmax(np.array(pred['predictions']), axis=-1)
# print(pred[0], '-', class_labels[pred[0]])
