from django.db import models
from django.conf import settings


upload_to = settings.STATIC_URL[1:]

# MAIN PAGE
class News(models.Model):
    title = models.CharField(max_length=30,help_text="Title")
    content = models.TextField()
    image = models.ImageField(
        upload_to = upload_to,
        null = True,
        help_text="Full url news"
    )
    date_created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-date_created"]