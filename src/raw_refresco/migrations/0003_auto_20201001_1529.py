# Generated by Django 3.1 on 2020-10-01 15:29

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('raw_refresco', '0002_auto_20201001_1526'),
    ]

    operations = [
        migrations.AlterField(
            model_name='timestamptransaction',
            name='tsintegrity',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='tx_list', to='raw_refresco.rawrefrescointegrity'),
        ),
    ]
