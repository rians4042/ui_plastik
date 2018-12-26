import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:plastik_ui/cache/user.dart';
import 'package:plastik_ui/domains/actor/api/actor.dart';
import 'package:plastik_ui/domains/actor/service/actor.dart';
import 'package:plastik_ui/helpers/httpclient/client.dart';

void injector(GetIt getIt) {
  UserCache _user = UserCacheImplementation();
  ActorAPI actorApi = ActorAPIImplementation(client: client(_user));
  getIt.registerSingleton<ActorService>(
      ActorServiceImplementation(api: actorApi));
}
