# install tensorflow on Mac OSX
sudo easy_install pip
sudo pip install --upgrade virtualenv
virtualenv --system-site-packages ~/tensorflow
source bin/activate
# easy_install -U pip
# pip install --upgrade tensorflow
pip install --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.3.0-py2-none-any.whl
# deactivate

# install tensorflow from sources
brew install bazel
# bazel version
sudo pip install six numpy wheel
git clone --recurse-submodules https://github.com/tensorflow/tensorflow
cd tensorflow
./configure
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
sudo pip install /tmp/tensorflow_pkg/tensorflow-1.2.0-cp27-cp27m-macosx_10_12_x86_64.whl

# uninstall tensorflow
# pip uninstall tensorflow
# rm -r ~/tensorflow

# validate tensorflow
import tensorflow as tf
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))
a = tf.constant(10)
b = tf.constant(32)
print sess.run(a+b)

# retrain Inception's final layer for new categories
cd ~
curl -O http://download.tensorflow.org/example_images/flower_photos.tgz
tar xzf flower_photos.tgz
tensorboard --logdir /tmp/retrain_logs
# http://localhost:6006
bazel build tensorflow/examples/image_retraining:retrain
bazel-bin/tensorflow/examples/image_retraining/retrain --image_dir ~/Downloads/flower_photos
# bazel-bin/tensorflow/examples/image_retraining/retrain --image_dir ~/Downloads/flower_photos --random_crop 5 --random_scale 5 --random_brightness 5

bazel build tensorflow/examples/label_image:label_image && \
bazel-bin/tensorflow/examples/label_image/label_image \
--graph=/tmp/output_graph.pb --labels=/tmp/output_labels.txt \
--output_layer=final_result --input_layer=Mul \
--image=$HOME/Downloads/flower_photos/daisy/21652746_cc379e0eea_m.jpg

# install TensorLayer
pip install git+https://github.com/zsdonghao/tensorlayer.git
import tensorlayer
