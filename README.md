# SoundShelter

## Contributors
- [Cao Thị Phương Anh](https://github.com/ctpanh)
- [Nguyễn Thị Thanh Thuỷ](https://github.com/NguyenThuy25)
- [Phạm Minh Tâm](https://github.com/21020391)

## Introduction
SoundShelter - a multi-platform music social network.

The key features are:
- Managing catalog:
  - Integrating artist information: Provide detailed information about the artist, including biography, albums, and other related information.
  - Classification by genre and author: The system will automatically categorize songs into different genres. Provide the ability to filter songs based on the author, year of production, and other factors.
  - User interaction: There are functions for users to choose from: play, stop, pause, next, prev, repeat.
- Personalization:
  - Upload music. (in process)
  - Favorite music.
  - Playlist. (in process)
  - Interaction (like, comment, share). (in process)
  - Offline music (mobile). (in process)
- Recommendations.
- Sleep timer. (in process)
- Charts.

## Technology
- Frontend: NextJS, TailwindCSS.
- Mobile: Flutter.
- Backend: FastAPI.
- Database: MySQL.

## Quickstart
```bash
# clone project
git clone https://github.com/ctpanh/SoundShelter.git
cd SoundShelter

# run backend
cd server
pip install -r requirements.txt
uvicorn main:app --reload

# add data for the first time
Call API http://localhost:8000/api/data/
- Interface: Go to [http://localhost:8000/docs#/default/save_data_api_data_get](http://localhost:8000/docs#/Data/save_data_api_data__get)
- Command line: curl -X 'GET' \ 'http://localhost:8000/api/data/' \ -H 'accept: application/json'

# run frontend
cd client
yarn install
yarn run dev
```
