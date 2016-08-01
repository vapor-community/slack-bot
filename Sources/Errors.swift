enum BotError: Swift.Error {
    /*:
     Expect file in `Config/bot-config.json` that looks like the following

     {
     "token": "[your - token - here]"
     }
     */
    case missingConfig

    /*:
     Got an invalid response from RTM api
     */
    case invalidResponse
}
