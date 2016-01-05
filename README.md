# READ THE API DOCS AT [docs.moduleok.apiary.io](http://docs.moduleok.apiary.io/)

---

## Old API documentation

#### /api/getNews

Returns recent news from [tneu.edu.ua](http://tneu.edu.ua) with photos and file attachments.

##### Parameters 
| Name       | Expected value   | Default value | Description                                     |
| -----------|------------------|---------------|-------------------------------------------------|
| page       | 1 – ~200         | 1             | News page index                                 |
| count      | 0 – 15           | 15            | Number of news posts                            |
| fullText   | `true` / `false` | `false`       | Download full news text, photos and attachments |

GET: `http://moduleok-api.meteor.com/api/getNews?page=3&count=1&fullText=true`

```json
{
    "title": "Арт-форум Пам’ятаю. Зима, що триває",
    "date": "13-02-2015, 12:59",
    "description": "З 18 лютого, у річницю одного із найтрагічніших днів в історії незалежності України, за ініціативи Дому освіти та культури «Майстер Клас» розпочнеться арт-форум «Пам’ятаю. Зима, що триває».",
    "image": "http://www.tneu.edu.ua/uploads/posts/2015-02/1423825121_1423480538_1495324_1056750557684042_1214902483212866146_o.jpg",
    "readMoreLink": "http://www.tneu.edu.ua/news/5117-art-forum-pamyatayu-zima-scho-trivaye.html",
    "fullText": "З 18 лютого, у річницю одного із найтрагічніших днів в історії незалежності України, за ініціативи Дому освіти та культури «Майстер Клас» розпочнеться арт-форум «Пам’ятаю. Зима, що триває». Проект присвячений революції Гідності й Героям Небесної сотні, але не обмежується подіями минулої зими. На Майдані розпочалася наша боротьба за свободу визначати власне майбутнє, за оновлення України. І вона триває досі.\\nАрт-форум «Пам’ятаю…» продовжує ідею першого проекту «Форум Громади Києва». Це міждисциплінарна мистецько-дискусійна платформа, мета якої об’єднати небайдужих людей навколо спільної пам’яті про Майдан і бачення майбутнього України.\\nПроект має благодійну ціль – зібрати кошти на евакуацію мирного населення і дітей із зони бойових дій.\\nЗахід складається із музичної, виставкової, лекційно-дискусійної, театральної, дитячої програм і кінопоказів.",
    "photos": ["http://www.tneu.edu.ua/engine/download.php?id=1536", "http://www.tneu.edu.ua/engine/download.php?id=1535"],
    "attachments": [{
        "name": "Анонс.pdf",
        "link": "http://www.tneu.edu.ua/engine/download.php?id=1536"
    }, {
        "name": "Календар подій.pdf",
        "link": "http://www.tneu.edu.ua/engine/download.php?id=1535"
    }]
}
```
