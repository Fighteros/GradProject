"""add default image

Revision ID: 9ebe14650712
Revises: 575f955a6831
Create Date: 2022-04-26 22:25:27.457866

"""
from alembic import op
import sqlalchemy as sa
from app.models import Image

# revision identifiers, used by Alembic.
revision = '9ebe14650712'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.bulk_insert(Image.__table__, [
        {'url': 'https://xhealth.blob.core.windows.net/profile/default.png'}
    ]
    )


def downgrade():
    pass
