import os, sys
from flask import Flask
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
from db_models import t_members


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://globality:globality@172.72.72.10:5432/globality'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

if app.config['SQLALCHEMY_DATABASE_URI'] == None:
    print "Need database config"
    sys.exit(1)

db = SQLAlchemy(app)
# db.create_all()
# db.session.commit()

@app.route('/')
def main():
    mymembers = db.session.query(t_members).all()
    return render_template('index.html', mymembers=mymembers)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0',port=5000, debug=True)
