# install tensorflow
sudo easy_install pip
virtualenv --system-site-packages ~/tensorflow
source ~/tensorflow/bin/activate
easy_install -U pip
pip install --upgrade tensorflow
# pip install --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.2.0-py2-none-any.whl

# uninstall tensorflow
# deactivate
# pip uninstall tensorflow
# rm -r ~/tensorflow

# validate tensorflow
import tensorflow as tf
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))
