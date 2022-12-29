from rest_framework.schemas import ManualSchema
import coreapi
import coreschema

class MyOwnSchema(ManualSchema):

    def __init__(self,description):

        # main_info="description"
        locations = ["path","query","form","body"]
        fields = []

        d1 = description.find("description:")+len("description:")
        d2 = description.find(":description")
        for location in locations:
            l1 = description.find(location+":")
            l2 = description.find(":"+location)
            if(l1!=-1 and l2!=-1):
                loc = description[l1+len(location)+1:l2]
                founded = -1
                while(True):
                    n1 = loc.find("- ",founded+1)
                    if n1==-1:
                        break
                    n2 = loc.find("<->",n1)
                    if n2==-1:
                        break
                    name = loc[n1+len("- "):n2]
                    t = loc[n2+len("<->"):]
                    t1 = t.find("<->")
                    if t1==-1:
                        required = False
                    else:
                        
                        required = (t[:t1].strip()=="required")
                    fields.append(
                        coreapi.Field(
                            name,
                            required=required,
                            location=location,
                            schema=coreschema.String()
                        )
                    )
                    founded = n1
        

        super().__init__(fields, description[d1:d2], "application/json")