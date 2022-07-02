"""init userlevel

Revision ID: 52ab22509a2d
Revises: 2abca3572287
Create Date: 2022-04-19 15:42:46.412495

"""
from alembic import op

from app.models import UserLevel

# revision identifiers, used by Alembic.
revision = '52ab22509a2d'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.bulk_insert(UserLevel.__table__, [
        {"user_level": "admin"},
        {"user_level": "doctor"},
        {"user_level": "patient"}
    ], multiinsert=False)


def downgrade():
    op.drop_table(UserLevel.__table__)
    op.create_table(UserLevel.__table__)
