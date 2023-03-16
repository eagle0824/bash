import json
import xmltodict
#定义xml转json的函数
def xmltojson(xmlstr):
      #parse是的xml解析器
        xmlparse = xmltodict.parse(xmlstr)
          #json库dumps()是将dict转化成json格式，loads()是将json转化成dict格式。
            #dumps()方法的ident=1，格式化json
              jsonstr = json.dumps(xmlparse,indent=1)
                print(jsonstr)
                if __name__ == "__main__":
                      xml ="""     #需要转换json格式的xml
                      <student>
                        <stid>10213</stid>
                          <info>
                              <name>name</name>
                                  <sex>male</sex>
                                    </info>
                                      <course>
                                          <name>math</name>
                                              <score>90</score>
                                                </course>
                                                </student>
                                                  """
                                                    xmltojson(xml) #调用转换函数
