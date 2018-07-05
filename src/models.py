from pynamodb.models import Model
from pynamodb.attributes import (
    UnicodeAttribute, NumberAttribute, UnicodeSetAttribute, UTCDateTimeAttribute
)
from datetime import datetime


class Todo(Model):
    class Meta:
        read_capcity_units = 1
        write_capacity_units = 1
        table_name = 'Todos'
    id = UnicodeAttribute(hash_key=True)
    text = UnicodeAttribute()