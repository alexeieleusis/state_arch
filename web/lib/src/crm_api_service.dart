import 'dart:async';
import 'dart:html';

import 'package:protobuf/protobuf.dart';
import 'package:protos/api.pb.dart';
import 'package:protos/entities.pb.dart';

class CrmApiService implements CrmServerApi {
  static const _apiPath = '/api';
  static const _companiesPath = '/companies';
  static const _opportunitiesPath = '/opportunities';
  static const _productsPath = '/opportunities';

  static const _getMethod = 'GET';
  static const _postMethod = 'POST';
  static const _putMethod = 'PUT';
  static const _deleteMethod = 'DELETE';

  @override
  Future<Company> createCompany(ClientContext ctx, Company request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request('$_apiPath$_companiesPath',
        method: _postMethod, sendData: buffer);
    return new Company.fromBuffer((httpRequest.response as String).codeUnits);
  }

  @override
  Future<Opportunity> createOpportunity(
      ClientContext ctx, Opportunity request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_opportunitiesPath',
        method: _postMethod,
        sendData: buffer);
    return new Opportunity.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Product> createProduct(ClientContext ctx, Product request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request('$_apiPath$_productsPath',
        method: _postMethod, sendData: buffer);
    return new Product.fromBuffer((httpRequest.response as String).codeUnits);
  }

  @override
  Future<Empty> deleteCompany(ClientContext ctx, Company request) async {
    final buffer = request.writeToBuffer();
    await HttpRequest.request('$_apiPath$_companiesPath',
        method: _deleteMethod, sendData: buffer);
    return new Empty();
  }

  @override
  Future<Empty> deleteOpportunity(
      ClientContext ctx, Opportunity request) async {
    final buffer = request.writeToBuffer();
    await HttpRequest.request('$_apiPath$_opportunitiesPath',
        method: _deleteMethod, sendData: buffer);
    return new Empty();
  }

  @override
  Future<Empty> deleteProduct(ClientContext ctx, Product request) async {
    final buffer = request.writeToBuffer();
    await HttpRequest.request('$_apiPath$_productsPath',
        method: _deleteMethod, sendData: buffer);
    return new Empty();
  }

  @override
  Future<CompaniesResponse> getCompanies(
      ClientContext ctx, Empty request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request('$_apiPath$_companiesPath',
        method: _getMethod, sendData: buffer);
    return new CompaniesResponse.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Company> getCompany(ClientContext ctx, Company request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_companiesPath${_idPlaceholder(request.id)}',
        method: _getMethod,
        sendData: buffer);
    return new Company.fromBuffer((httpRequest.response as String).codeUnits);
  }

  @override
  Future<OpportunitiesResponse> getOpportunities(
      ClientContext ctx, Empty request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_opportunitiesPath',
        method: _getMethod,
        sendData: buffer);
    return new OpportunitiesResponse.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Opportunity> getOpportunity(
      ClientContext ctx, Opportunity request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_opportunitiesPath${_idPlaceholder(request.id)}',
        method: _getMethod,
        sendData: buffer);
    return new Opportunity.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Product> getProduct(ClientContext ctx, Product request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_productsPath${_idPlaceholder(request.id)}',
        method: _getMethod,
        sendData: buffer);
    return new Product.fromBuffer((httpRequest.response as String).codeUnits);
  }

  @override
  Future<ProductsResponse> getProducts(ClientContext ctx, Empty request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request('$_apiPath$_productsPath',
        method: _getMethod, sendData: buffer);
    return new ProductsResponse.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Company> updateCompany(ClientContext ctx, Company request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_companiesPath${_idPlaceholder(request.id)}',
        method: _putMethod,
        sendData: buffer);
    return new Company.fromBuffer((httpRequest.response as String).codeUnits);
  }

  @override
  Future<Opportunity> updateOpportunity(
      ClientContext ctx, Opportunity request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_opportunitiesPath${_idPlaceholder(request.id)}',
        method: _putMethod,
        sendData: buffer);
    return new Opportunity.fromBuffer(
        (httpRequest.response as String).codeUnits);
  }

  @override
  Future<Product> updateProduct(ClientContext ctx, Product request) async {
    final buffer = request.writeToBuffer();
    final httpRequest = await HttpRequest.request(
        '$_apiPath$_productsPath${_idPlaceholder(request.id)}',
        method: _putMethod,
        sendData: buffer);
    return new Product.fromBuffer((httpRequest.response as String).codeUnits);
  }

  String _idPlaceholder(int id) => '/{$id}';
}
