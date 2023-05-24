# from pytube import YouTube
# save_path = "C:/tmp/videos/"
# with open('50.txt', 'r') as f:
#     sdwlinks = f.read().splitlines()

# for i in sdwlinks:
#     try:
#         yt = YouTube(i).title
#         break
#         print(yt)
#     except:
#         sleep(1)
#         yt = YouTube(i)
        
        
 
 
from youtube_dl import *
YoutubeDL('https://www.youtube.com/watch?v=Mo2KcYzfH8c')