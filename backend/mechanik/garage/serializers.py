from rest_framework.serializers import ModelSerializer, ValidationError
from garage.models import Comment, OpeningHours
from  rest_framework.exceptions  import PermissionDenied

class CommentSerializer(ModelSerializer):

    class Meta:
        model =  Comment
        fields = "__all__"

class CommentClientSerializer(ModelSerializer):

    class Meta:
        model =  Comment
        fields = "__all__"

    def validate(self, attrs):

        user = self.context['request'].user
        authorid = self.context['request'].data.get('author')

        isExist = Comment.objects.filter(
            author=user.userinfo,author_id=authorid
        ).exists()

        if(not isExist):
            raise PermissionDenied("Brak uprawnień do zasobu")

        return super().validate(attrs)

class OpeningHoursSerializer(ModelSerializer):

    class Meta:
        model =  OpeningHours
        fields = ["pk","time_start","time_end"]

    def validate(self, attrs):
        """
        The date start and date end must be the same
        """
        if attrs['time_start'].day != attrs['time_end'].day:
            raise ValidationError("the dates must be the same!")
        if OpeningHours.objects.filter(time_start__day=attrs['time_start'].day).first():
            raise ValidationError("the date already exists")

        return attrs