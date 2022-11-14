from userinfo.models import UserInfo
from rest_framework.serializers import ModelSerializer

class UserInfoSerializer(ModelSerializer):

    # user = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = UserInfo
        fields = ['name','surname','phone_number','email','avatar']