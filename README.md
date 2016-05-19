# SNUCMS-Plus  
2016년 1학기 창의적통합설계 프로젝트  
18조 김형모 이산하 이수현

## 개발환경
- 개발 언어: Ruby (ver 2.2.3p173)
- 웹 프레임워크: Ruby On Rails (ver 4.2.4)
- frontend script: ES6 + jQuery + Reactjs
- frontend design: Semantic UI

## 브랜치 정책
- 최상위(릴리즈) 브랜치: master
- 개발 브랜치: develop
- 이슈 브랜치: issue number를 포함하도록.  

## PR 및 merge 정책(중요!!!)
- PR 보내기 전 rebase하기(이렇게 해야 브랜치 트리가 이쁘다)
- Merge는 PR을 보낸 사람 이외의 사람만 할 수 있다(가능한 한 코드 리뷰 열심히 하기!)  

### Rebase 방법
```bash
$ git checkout [base로 merge시킬 브랜치(ex: iss3)]
$ git rebase [merge할 base 브랜치(ex: development)]
$ git push 어쩌구 저쩌구
```
자세한 정보는 wiki 참고.

## 실행
```bash
$ bundle install
$ bundle exec rake db:migrate
$ rails s
(or, rails s -b 0.0.0.0)
```

## seed DB apply
```bash
$ rake db:seed
```
