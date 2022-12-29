from  rest_framework.exceptions  import ValidationError



def validate_int(count):
    if count is None:
            raise ValidationError("Brak podanego parametru")
    try:
        count = int(count)
    except ValueError:
        raise ValidationError("Wartośc nie jest liczbowa")
    else:
        if(count<=0):
            raise ValidationError("Wartość jest ujemna!")
        return count