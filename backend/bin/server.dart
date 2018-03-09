import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:domain/store/server_api.dart';
import 'package:protos/api.pb.dart';
import 'package:protos/entities.pb.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_proxy/shelf_proxy.dart' as proxy;
import 'package:shelf_route/shelf_route.dart' as route;
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_static/shelf_static.dart' as shelf_static;

void main(List<String> args) {
  final parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '8082')
    ..addOption('dev', abbr: 'd', defaultsTo: 'false');

  final result = parser.parse(args);

  final port = int.parse(result['port'], onError: (val) {
    stdout.writeln('Could not parse port value "$val" into a number.');
    exit(1);
  });

  _apiRouter..addAll(_apiRouteBuilder, path: '/api');

  final isDevelopmentEnvironment = result['dev'] == 'true';

  final handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_buildCascadeHandler(isDevelopmentEnvironment));

  io.serve(handler, '0.0.0.0', port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
//    server.last.then((_) {
//      // Persist the contents of _api.
//    });
  });
}

final _api = new ServerApi();

final _apiRouter = route.router();

final _proxyHandler = proxy.proxyHandler('http://localhost:8080/');

final _staticHandler = shelf_static.createStaticHandler('./static',
    serveFilesOutsidePath: true, defaultDocument: 'index.html');

route.Router _apiRouteBuilder(route.Router r) => r
  ..addAll(_companiesRouteBuilder, path: '/companies')
  ..addAll(_productsRouteBuilder, path: '/products')
  ..addAll(_opportunitiesRouteBuilder, path: '/opportunities');

Future<Iterable<int>> _buildBufferFromBody(shelf.Request request) async {
  final body =
      (await request.read().asBroadcastStream().toList()).expand((i) => i);
  return body;
}

/// Api router needs to be added before the proxy.
shelf.Handler _buildCascadeHandler(bool isDevMode) => new shelf.Cascade()
    .add(_apiRouter.handler)
    .add(isDevMode ? _proxyHandler : _staticHandler)
    .handler;

route.Router _companiesRouteBuilder(route.Router r) => r
  ..get('/', _getCompanies)
  ..get('/{id}', _getCompany)
  ..put('/{id}', _updateCompany)
  ..delete('/{id}', _deleteCompany)
  ..post('/', _createCompany);

Future<shelf.Response> _createCompany(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Company.fromBuffer(requestBody);
  final responseBody = (await _api.createCompany(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _createOpportunity(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Opportunity.fromBuffer(requestBody);
  final responseBody =
      (await _api.createOpportunity(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _createProduct(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Product.fromBuffer(requestBody);
  final responseBody = (await _api.createProduct(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _deleteCompany(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Company.fromBuffer(requestBody);
  final responseBody = (await _api.deleteCompany(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _deleteOpportunity(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Opportunity.fromBuffer(requestBody);
  final responseBody =
      (await _api.deleteOpportunity(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _deleteProduct(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Product.fromBuffer(requestBody);
  final responseBody = (await _api.deleteProduct(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _getCompanies(shelf.Request request) async {
  final responseBody =
      (await _api.getCompanies(null, new Empty())).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _getCompany(shelf.Request request) async {
  final id = _getIdFromRequest(request);
  final entity = await _api.getCompany(null, new Company()..id = id);
  return new shelf.Response.ok(entity.writeToBuffer());
}

int _getIdFromRequest(shelf.Request request) {
  final id = int.parse(getPathParameter(request, 'id').toString());
  return id;
}

Future<shelf.Response> _getOpportunities(shelf.Request request) async {
  final responseBody =
      (await _api.getOpportunities(null, new Empty())).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _getOpportunity(shelf.Request request) async {
  final id = _getIdFromRequest(request);
  final entity = await _api.getOpportunity(null, new Opportunity()..id = id);
  return new shelf.Response.ok(entity.writeToBuffer());
}

Future<shelf.Response> _getProduct(shelf.Request request) async {
  final id = _getIdFromRequest(request);
  final product = await _api.getProduct(null, new Product()..id = id);
  return new shelf.Response.ok(product.writeToBuffer());
}

Future<shelf.Response> _getProducts(shelf.Request request) async {
  final responseBody =
      (await _api.getProducts(null, new Empty())).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

route.Router _opportunitiesRouteBuilder(route.Router r) => r
  ..get('/', _getOpportunities)
  ..get('/{id}', _getOpportunity)
  ..put('/{id}', _updateOpportunity)
  ..delete('/{id}', _deleteOpportunity)
  ..post('/', _createOpportunity);

route.Router _productsRouteBuilder(route.Router r) => r
  ..get('/', _getProducts)
  ..get('/{id}', _getProduct)
  ..put('/{id}', _updateProduct)
  ..delete('/{id}', _deleteProduct)
  ..post('/', _createProduct);

Future<shelf.Response> _updateCompany(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Company.fromBuffer(requestBody);
  final responseBody = (await _api.updateCompany(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _updateOpportunity(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Opportunity.fromBuffer(requestBody);
  final responseBody =
      (await _api.updateOpportunity(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}

Future<shelf.Response> _updateProduct(shelf.Request request) async {
  final requestBody = await _buildBufferFromBody(request);
  final entity = new Product.fromBuffer(requestBody);
  final responseBody = (await _api.updateProduct(null, entity)).writeToBuffer();
  return new shelf.Response.ok(responseBody);
}
