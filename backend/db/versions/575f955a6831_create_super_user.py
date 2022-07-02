"""create super user

Revision ID: 575f955a6831
Revises: 52ab22509a2d
Create Date: 2022-04-21 15:10:55.307179

"""
from alembic import op
import sqlalchemy as sa
from app.models import User

# revision identifiers, used by Alembic.
from app.utils import hash_pass

revision = '575f955a6831'
down_revision = '52ab22509a2d'
branch_labels = None
depends_on = None


def upgrade():
    op.bulk_insert(User.__table__, [
        {
            "email": "admin@xhealth.com",
            "password": hash_pass("admin"),
            "first_name": "Admin",
            "last_name": "",
            "user_level_id": 1,
        }
    ])


def downgrade():
    op.execute("""
    DELETE FROM users WHERE email="admin@xhealth.com"}
    """)

