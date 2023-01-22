class SweetDry < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '甘口' },
    { id: 3, name: 'やや甘口' },
    { id: 4, name: '中辛' },
    { id: 5, name: 'やや辛口' },
    { id: 6, name: '辛口' }
  ]
 
   include ActiveHash::Associations
   has_many :drinks
 
  end