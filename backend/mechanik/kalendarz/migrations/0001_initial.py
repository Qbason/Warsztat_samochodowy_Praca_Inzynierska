# Generated by Django 4.1 on 2022-10-25 11:45

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='Car',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nr_VIN', models.CharField(max_length=20, unique=True)),
                ('photo', models.ImageField(null=True, upload_to='static/')),
            ],
        ),
        migrations.CreateModel(
            name='CarBrand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('brand', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='CarModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('model', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='CarPlace',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('image', models.ImageField(null=True, upload_to='static/')),
            ],
        ),
        migrations.CreateModel(
            name='CarType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='ItemBase',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('condition', models.CharField(choices=[('N', 'New'), ('U', 'Used'), ('D', 'Damaged')], max_length=10)),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='kalendarz.category')),
            ],
        ),
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
        migrations.CreateModel(
            name='OpeningHours',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time_start', models.DateTimeField()),
                ('time_end', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='ServiceName',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, unique=True)),
                ('price', models.DecimalField(decimal_places=2, max_digits=8, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='UserInfo',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('name', models.CharField(max_length=30)),
                ('surname', models.CharField(max_length=30)),
                ('phone_number', models.CharField(max_length=30)),
                ('email', models.EmailField(max_length=100)),
                ('avatar', models.ImageField(default='default-avatar.jpg', upload_to='static/')),
                ('role', models.CharField(choices=[('M', 'Mechanic'), ('C', 'Client')], max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='VisitDescription',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('content', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='VisitReason',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('reason', models.CharField(max_length=100, unique=True)),
                ('duration', models.PositiveSmallIntegerField(default=0)),
            ],
        ),
        migrations.CreateModel(
            name='Offer',
            fields=[
                ('title', models.CharField(max_length=100)),
                ('description', models.TextField()),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('image', models.ImageField(null=True, upload_to='static/')),
                ('itembase', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, primary_key=True, serialize=False, to='kalendarz.itembase')),
                ('hide', models.BooleanField(default=False)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'ordering': ['-date_created'],
            },
        ),
        migrations.CreateModel(
            name='Visit',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_accepted', models.BooleanField(default=False)),
                ('date_visit', models.DateTimeField()),
                ('date_visit_end', models.DateTimeField(null=True)),
                ('date_created_visit', models.DateTimeField(auto_now_add=True)),
                ('car', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.car')),
                ('carplace', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.carplace')),
                ('visitdescription', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.visitdescription')),
                ('visitreason', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.visitreason')),
            ],
        ),
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('price', models.DecimalField(decimal_places=2, max_digits=8, null=True)),
                ('progress', models.CharField(choices=[('T', 'Do zrobienia'), ('D', 'W trakcie'), ('DN', 'Zrobione')], max_length=20)),
                ('date_start', models.DateTimeField(auto_now_add=True)),
                ('duration', models.SmallIntegerField(default=0)),
                ('date_end', models.DateTimeField()),
                ('servicename', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.servicename')),
            ],
        ),
        migrations.CreateModel(
            name='Reservation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('date_receive', models.DateTimeField()),
                ('was_taken', models.BooleanField()),
                ('client', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.userinfo')),
            ],
        ),
        migrations.CreateModel(
            name='Repair',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cartaken', models.BooleanField(default=False)),
                ('services', models.ManyToManyField(to='kalendarz.service')),
                ('visit', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.visit')),
            ],
        ),
        migrations.CreateModel(
            name='Item',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('itembase', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.itembase')),
                ('reservation', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.reservation')),
            ],
        ),
        migrations.CreateModel(
            name='Event',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('content', models.TextField()),
                ('date_start', models.DateTimeField()),
                ('date_end', models.DateTimeField()),
                ('carplace', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.carplace')),
                ('service', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.service')),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=50)),
                ('content', models.TextField()),
                ('stars', models.PositiveSmallIntegerField(default=5)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('author', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.userinfo')),
            ],
        ),
        migrations.CreateModel(
            name='CarBrandModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('carbrand', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.carbrand')),
                ('carmodel', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.carmodel')),
            ],
        ),
        migrations.AddField(
            model_name='car',
            name='carbrandmodel',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.carbrandmodel'),
        ),
        migrations.AddField(
            model_name='car',
            name='cartype',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.cartype'),
        ),
        migrations.AddField(
            model_name='car',
            name='owner',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.userinfo'),
        ),
        migrations.CreateModel(
            name='Opinion',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('content', models.TextField()),
                ('number_of_stars', models.PositiveIntegerField()),
                ('date_created', models.DateTimeField()),
                ('offer', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='kalendarz.offer')),
            ],
        ),
    ]
