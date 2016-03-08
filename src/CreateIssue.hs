{-# LANGUAGE OverloadedStrings #-}

module CreateIssue where

import qualified Github.Auth   as Github
import qualified Github.Issues as Github

createIssue :: IO ()
createIssue = do
  let auth = Github.GithubBasicAuth "amitaibu" ""
      newiss = (Github.newIssue "A new issue")
        { Github.newIssueBody = Just "Issue description text goes here"
        , Github.newIssueLabels = Just []
        }
  possibleIssue <- Github.createIssue auth "amitaibu" "csv2github-demo" newiss
  putStrLn $ either (\e -> "Error: " ++ show e)
                    formatIssue
                    possibleIssue

formatIssue issue =
  (Github.githubOwnerLogin $ Github.issueUser issue) ++
    " opened this issue " ++
    (show $ Github.fromGithubDate $ Github.issueCreatedAt issue) ++ "\n" ++
    (Github.issueState issue) ++ " with " ++
    (show $ Github.issueComments issue) ++ " comments" ++ "\n\n" ++
    (Github.issueTitle issue)
