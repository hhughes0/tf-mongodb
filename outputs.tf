output "connection_strings" {
  value = flatten([
    for tg in module.mongodb[*] : [
      for str in tg.connection_strings : [
        for coll in str.mongoCollection : [
          for p in tg.pwd : [
            { Connection_string = format("mongodb+srv://%s:%s@%s/%s/%s", str.serviceName, p[str.serviceName].result, str.mongoCluster, str.mongoDatabase, coll) }
          ]
        ]
      ]
    ]
  ])
}
