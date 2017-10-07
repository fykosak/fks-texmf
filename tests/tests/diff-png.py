import sys
import matplotlib.image as img
import numpy as np

convolve = False

if len(sys.argv) != 4:
    print sys.argv
    print "Parameters number" + (len(sys.argv)-1) + "!=3"
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

# dalculate difference
diff = imAbw - imBbw
diff[ np.abs( diff ) < .5 ] = 0
diff_pts = np.where( diff != 0 )[0]

black   = np.prod( np.where( (imBbw + imAbw) < 1.5 )[0].shape )
diffavg = np.sum( np.abs(diff) ) / black
diffcnt = np.prod( diff_pts.shape )

# test average difference
if diffavg > 1e-6:
    print "Average difference " + str( diffavg ) + " > 1e-6."
    error = -1
# test number od diferrent points
if diffcnt > black * 1e-4:
    print "Number of different pixels " + str( (1.*diffcnt) / black ) + " > 1e-4"
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

