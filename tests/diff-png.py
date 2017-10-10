#!/usr/bin/env python
import sys
import matplotlib.image as img
import numpy as np

convolve = False

if len(sys.argv) < 4:
    print sys.argv
    print "Usage: %s a.png b.png diff.png [-r LxT,WxH] [-t threshold]" % sys.argv[0]
    sys.exit( 1 )

try:
    im_refr = img.imread(sys.argv[1])
except IOError:
    print "Error openning file" + sys.argv[1]
    sys.exit( 2 )
try:
    im_test = img.imread(sys.argv[2])
except IOError:
    print "Error openning file" + sys.argv[2]
    sys.exit( 2 )

if im_refr.shape != im_test.shape:
    print "Shapes are different. " + str(im_refr.shape) + " " + str(im_test.shape)
    sys.exit( 3 )

# Default paramters
lt = (0,0)
size = (1,1)

threshold_avg = 1e-6
threshold_cnt = 1e-4

# Simple arguments parsing
parse_argv = sys.argv[4:]

while len(parse_argv) > 0:
    if parse_argv[0] == "-r":
        roi = parse_argv[1]
        roi = roi.split(",")
        lt = [float(x) for x in roi[0].split("x")]
        size = [float(x) for x in roi[1].split("x")]
        parse_argv = parse_argv[2:]
    elif parse_argv[0] == "-t":
        threshold_avg = float(parse_argv[1])
        threshold_cnt = 100 * threshold_avg
        parse_argv = parse_argv[2:]


w = im_refr.shape[1]
h = im_refr.shape[0]

lt = int(w*lt[0]), int(h*lt[1])
size = int(w*size[0]), int(h*size[1])

im_refr = im_refr[lt[1]:lt[1]+size[1], lt[0]:lt[0]+size[0]]
im_test = im_test[lt[1]:lt[1]+size[1], lt[0]:lt[0]+size[0]]

error=0

# sum colors
imAbw = ( im_refr[:,:,0] + im_refr[:,:,1] + im_refr[:,:,2] ) / 3
imBbw = ( im_test[:,:,0] + im_test[:,:,1] + im_test[:,:,2] ) / 3

if convolve == True:
    i = np.arange(-2,3,1)
    j = np.arange(-2,3,1)

    i = np.repeat(i, 5).reshape((5,5))
    j = np.repeat(j, 5).reshape((5,5)).T

    w = 1./(1.+i*i+j*j)
    w = w / np.sum(w)

    from scipy import signal
    imAbw = signal.convolve2d(imAbw, w, boundary='symm', mode='same')
    imBbw = signal.convolve2d(imBbw, w, boundary='symm', mode='same')

# calculate difference
diff = imAbw - imBbw
diff[ np.abs( diff ) < .5 ] = 0
diff_pts = np.where( diff != 0 )[0]

black   = np.prod( np.where( (imBbw + imAbw) < 1.5 )[0].shape )
diffavg = np.sum( np.abs(diff) ) / black
diffcnt = np.prod( diff_pts.shape )

# test average difference
if diffavg > threshold_avg:
    print "Average difference %g > %g" % (diffavg, threshold_avg,)
    error = -1
# test number od diferrent points
if diffcnt > black * threshold_cnt:
    print "Number of different pixels %g > %g" % ((1.*diffcnt)/black, threshold_cnt,)
    error = -2

print "black   =", black
print "diffcnt =", diffcnt
print "diffavg =", diffavg

# plot diff image
diffP =  diff
diffM = -diff

diffP[ diffP < 0 ] = 0
diffM[ diffM < 0 ] = 0

if np.amax( diffP ) != 0:
    diffP = diffP / np.amax( diffP )
if np.amax( diffM ) != 0:
    diffM = diffM / np.amax( diffM )

im_test[:,:,0] = diffP
im_test[:,:,1] = diffM
im_test[:,:,2] = ( im_refr[:,:,0] + im_refr[:,:,1] + im_refr[:,:,2] ) / 3

img.imsave( sys.argv[3], im_test )

if error != 0:
    print "Files are different. See " + sys.argv[3] + " for details."
    sys.exit( error )
sys.exit( 0 )


