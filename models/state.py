#!/usr/bin/python3
""" State Module for HBNB project """
from os import getenv

from sqlalchemy import Column, String
from sqlalchemy.orm import relationship

from models import storage
from models.base_model import BaseModel, Base
from models.city import City


class State(BaseModel, Base):
    """ State class """
    __tablename__ = 'states'

    name = Column(String(128), nullable=False)

    if getenv('HBNB_TYPE_STORAGE') == 'db':
        cities = relationship('City', backref='state', cascade='all')

    else:
        def cities(self):
            """Return the list of city instances with state_id"""
            city_list = []

            for ct in storage.all(City).values():
                if ct.state.id == self.id:
                    city_list.append(ct)

            return city_list
