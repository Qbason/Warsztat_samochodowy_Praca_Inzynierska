from userinfo.models import UserInfo, GeneratedCode
from rest_framework.serializers import ModelSerializer

class UserInfoSerializer(ModelSerializer):

    # user = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = UserInfo
        fields = ['pk','name','surname','phone_number','email','avatar','role']


class  GeneratedCodeSerializer(ModelSerializer):

    class Meta:
        model = GeneratedCode
        fields = '__all__'

