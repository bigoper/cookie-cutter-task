# coding: utf-8
from sqlalchemy import Column, Integer, MetaData, String, Table, text


metadata = MetaData()

t_members = Table(
    'members', metadata,
    Column('id', Integer, nullable=False, server_default=text("nextval('t_globality_id_seq'::regclass)")),
    Column('f_name', String(24)),
    Column('l_name', String(24)),
    Column('email', String(55)),
    Column('mobile', String(15))
)
