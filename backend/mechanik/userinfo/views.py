from rest_framework import generics
from rest_framework import viewsets
from rest_framework.exceptions import NotFound
from rest_framework.response import Response

from userinfo.models import UserInfo
from userinfo.serializer import UserInfoSerializer

from basetools.schema import MyOwnSchema

class UserInfoViewSet(viewsets.ModelViewSet):
    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)


class MyUserInfo(generics.GenericAPIView):
    """
    Show info about logged in user
    """


    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

    def get_queryset(self):

        user = self.request.user

        userinfo = UserInfo.objects.filter(user=user).first()

        if not userinfo:
            raise NotFound
        
        return userinfo

    def get(self,*args, **kwargs):
        """
        description:
        Return info about logged in user like: name, surname,
        phone_number, email, avatar
        :description
        """
        userinfo = self.get_queryset()
        serializered_userinfo = self.get_serializer(userinfo,many=False)

        return Response(serializered_userinfo.data)

    schema = MyOwnSchema(get.__doc__)