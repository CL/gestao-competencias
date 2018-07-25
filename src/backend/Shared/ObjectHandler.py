def object_handler(obj):
    if hasattr(obj, 'to_dict'):
        return obj.to_dict()
    else:
        raise TypeError('Object of type {0} with value of {1} is not JSON serializable'.format(type(obj), repr(obj)))
