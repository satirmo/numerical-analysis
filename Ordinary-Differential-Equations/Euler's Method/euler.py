import numpy as np
import matplotlib.pyplot as plt

def f(t, y):
    """An ordinary differential equation of two variables (t and y). This
    function must return a floating-point value.
    Args:
        t (float): The value of the variable t.
        y (float): The value of the variable y.
    Returns:
        float: The value of the function at the given point.
    """

    return y * (1 - y)

def euler(t0, y0, f, upper_bound, points):
    """This function simulates Euler's method for an ordinary differential
    equation of two variables (t and y). A plot with the estimated points and
    their respective tangents is generated.
    Args:
        t0 (float): The minimum value of t
        y0 (float): The value of y evaulated at t = t0, i.e. y0 = y(t0)
        f (function): A function defined in terms of t and y. This function
            must return a scalar.
        upper_bound (float): The maximum value of t that will plotted.
        points (int): The number of points that will be plotted.
    Returns:
        None
    """

    h = (upper_bound - t0) / (points - 1)

    tns = [t0 + k * h for k in range(points)]
    yns = [y0]

    for i in range(1, points):
        t_prev = tns[i - 1]
        y_prev = yns[i - 1]

        y_curr = y_prev + h * f(t_prev, y_prev)
        yns.append(y_curr)

    plt.plot(tns, yns, 'ko')

    for i in range(points):
        x = tns[i]
        y = yns[i]

        dx = h / 3
        dy = f(x, y)
        
        xs = [x - dx, x + dx]
        ys = [y - dx * dy, y + dx * dy]

        plt.plot(xs, ys, 'g')

    title = 'Euler\'s Method Applied to y\' = y(1 - y) with %d points'\
        % (points)

    plt.xlabel('t')
    plt.ylabel('y')
    plt.title(title)
    plt.show()

y0 = 0.1
t0 = 0
upper_bound = 10

euler(t0, y0, f, upper_bound, points = 2)
euler(t0, y0, f, upper_bound, points = 4)
euler(t0, y0, f, upper_bound, points = 8)
euler(t0, y0, f, upper_bound, points = 16)
