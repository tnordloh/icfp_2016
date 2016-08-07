from fractions import Fraction
from itertools import chain
import numpy as np
from functools import partial
from scipy.optimize import minimize_scalar
class Point(object):
    def __init__(self,x,y):
        self.x = Fraction(x)
        self.y = Fraction(y)

    def __add__(self, other):
        return Point(self.x+other.x, self.y+other.y)

    def __sub__(self, other):
        return Point(self.x-other.x, self.y-other.y)

    def __str__(self):
        return "%s, %s"%(str(self.x),str(self.y))
        
    def distance(self, other):
        return np.sqrt(float((self.x-other.x)**2 + (self.y-other.y)**2 ))

        
def parse_silohette(filename):
    f = open(filename)
    num_polygons = int(f.readline().strip())
    polygons = []
    for i in range(num_polygons):
        points = []
        num_points = int(f.readline().strip())
        for j in range(num_points):
            p = tuple(f.readline().strip().split(','))
            points.append(Point(*p))
        polygons.append(points)

    return polygons

def make_single_polygon(polygons):
    positive_polys = []
    for poly in polygons:
        if not clockwise(poly):
            positive_polys.append(poly)
    return [point for point in chain(*positive_polys)]
    
    
def compute_centroid(polygon):
    avgx = sum((p.x for p in polygon))/len(polygon)
    avgy = sum((p.y for p in polygon))/len(polygon)
    return Point(avgx, avgy)

def compute_bounding_box(polygon):
    maxx = max((p.x for p in polygon))
    maxy = max((p.y for p in polygon))
    minx = min((p.x for p in polygon))
    miny = min((p.y for p in polygon))
    return Point(minx,miny), Point(maxx,miny), Point(maxx, maxy), Point(minx,maxy)

def clockwise(polygon):
    pp2 = polygon[1:] + [polygon[0]]
    clockwise_sum = sum(( (x2.x-x1.x)/(x1.y+x2.y) for x1,x2 in zip(polygon, pp2)))
    return clockwise_sum < 0


    
def rotate_point(point, rotation_point, angle_in_degrees):
    temp = point-rotation_point
    # (x) (cos -sin)   (x)
    # ( )=(        ) * ( )
    # (y) (sin  cos)   (y)
    c = round(np.cos(np.radians(angle_in_degrees)),10)
    s = round(np.sin(np.radians(angle_in_degrees)),10)
    newpt = Point(c*temp.x-s*temp.y, s*temp.x+c*temp.y)
    return newpt+rotation_point

def bb_area(bb_points):
    ##THIS WILL NOT WORK FOR A NOT-RECTANGLE
    distances = bb_lengths(bb_points)
    return np.multiply.reduce(distances)

def bb_lengths(bb_points):
    bb2 = list(bb_points[1:]) + [bb_points[0]]
    distances = tuple(set([x1.distance(x2) for x1,x2 in zip(bb_points, bb2)]))
    return distances
    
def rotated_bb_area(polygon, center, angle_in_degrees):
    return bb_area(rotated_bb(polygon, center, angle_in_degrees))

def rotated_bb(polygon, center, angle_in_degrees):
    rotated_polygon = [rotate_point(p, center, angle_in_degrees) for p in polygon]
    bb = compute_bounding_box(rotated_polygon)
    return bb
    
def optimize_bounding_box(polygons):
    polygon = make_single_polygon(polygons)
    #print "len polygon is %d"%len(polygon)
    center = compute_centroid(polygon)
    afunc = partial(rotated_bb_area, polygon, center)
    min_area = 999999999999999
    min_angle = 0
    angles_to_test = [10., -10., -30., -50., -70., -90., -110.]#, -40., -50., -60., -70., -80., -90.]
    for i, center_angle in enumerate(angles_to_test[1:-1]):
        b1 = angles_to_test[i]
        b2 = angles_to_test[i+2]
        #print b2,b1
        res = minimize_scalar(afunc, bounds=(b2,b1), method='bounded')
        x = res.x
        ta = afunc(x)
        #print x, ta
        if ta < min_area and res.success:
            min_area = ta
            min_angle = -x
    polygon_rotated_bb = rotated_bb(polygon, center, -min_angle)
    #now rotate this bb back by min_angle
    actual_bb = [rotate_point(p, center, min_angle) for p in polygon_rotated_bb]
    return round(min_angle, 2), actual_bb, center

if __name__ == '__main__':
    import sys
    problem_file = sys.argv[1]
    polygs = parse_silohette(problem_file)
    min_angle, bb, center = optimize_bounding_box(polygs)
    print 'angle =',min_angle
    for i,p in enumerate(bb):
        print 'point%d ='%i,p
    lengths = bb_lengths(bb)
    width = bb[0].distance(bb[1])
    length = bb[1].distance(bb[2])
    print 'width =', Fraction(width)
    print 'length =',Fraction(length)
    print 'center =', center
    
        
