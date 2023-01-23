class BestTime < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '仕事終わり' },
    { id: 3, name: '夕食時' },
    { id: 4, name: '夕食後' },
    { id: 5, name: 'お風呂前' },
    { id: 6, name: 'お風呂上がり' },
    { id: 7, name: '寝る前' },
    { id: 8, name: '夜中' },
    { id: 9, name: '朝から' },
    { id: 10, name: 'お昼から' },
    { id: 11, name: '特別な日' }
  ]
 
   include ActiveHash::Associations
   has_many :drinks
 
  end