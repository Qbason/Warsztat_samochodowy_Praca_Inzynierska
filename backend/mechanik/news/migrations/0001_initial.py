# Generated by Django 4.1 on 2022-11-14 20:45

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='News',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(help_text='Title', max_length=30)),
                ('content', models.TextField()),
                ('image', models.ImageField(help_text='Full url news', null=True, upload_to='static/')),
                ('date_created', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'ordering': ['-date_created'],
            },
        ),
    ]
