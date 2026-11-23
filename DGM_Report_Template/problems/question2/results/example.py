"""Small code-listing example."""


def mean_squared_error(target, prediction):
    if len(target) != len(prediction) or not target:
        raise ValueError("Inputs must be nonempty and equally sized.")
    squared_errors = [(x - y) ** 2 for x, y in zip(target, prediction)]
    return sum(squared_errors) / len(target)


print(mean_squared_error([1.0, 2.0, 3.0], [0.9, 2.1, 2.8]))
