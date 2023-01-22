class Genre < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ビール' },
    { id: 3, name: 'ワイン（赤、白、ロゼ、スパークリングなど）' },
    { id: 4, name: 'カクテル' },
    { id: 5, name: 'ウイスキー' },
    { id: 6, name: '日本酒・焼酎（麦、芋など）' },
    { id: 7, name: '酎ハイ・サワー' },
    { id: 8, name: '果実酒' },
    { id: 9, name: '外国酒' },
    { id: 10, name: 'ノンアル' },
    { id: 11, name: 'Others' }
  ]
 
   include ActiveHash::Associations
   has_many :drinks
 
  end