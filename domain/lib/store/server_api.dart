import 'dart:async';
import 'dart:math';

import 'package:domain/store/companies_factory.dart';
import 'package:protobuf/protobuf.dart';
import 'package:protos/api.pb.dart';
import 'package:protos/entities.pb.dart';
import 'package:protos/server_state.pb.dart';

class ServerApi implements CrmServerApi {
  final _state = new ServerState();


  ServerApi() {
    final companiesFactory = new CompaniesFactory();
    for (var i = 0; i < 15; i++) {
      _state.companies.add(companiesFactory.createCompany());
    }
  }

  @override
  Future<Company> createCompany(ClientContext ctx, Company request) {
    final entities = _state.companies;
    final ids = entities.map((c) => c.id);
    if (entities.contains(request) || ids.contains(request.id)) {
      throw new UnsupportedError('Company already exists.');
    }
    entities.add(request);
    if (request.id == null || request.id == 0) {
      request.id = ids.isEmpty ? 1 : ids.reduce(max) + 1;
    }

    return new Future.value(request);
  }

  @override
  Future<Opportunity> createOpportunity(
      ClientContext ctx, Opportunity request) {
    final entities = _state.opportunities;
    final ids = entities.map((c) => c.id);
    if (entities.contains(request) || ids.contains(request.id)) {
      throw new UnsupportedError('Opportunity already exists.');
    }
    entities.add(request);
    if (request.id == null || request.id == 0) {
      request.id = ids.isEmpty ? 1 : ids.reduce(max) + 1;
    }

    return new Future.value(request);
  }

  @override
  Future<Product> createProduct(ClientContext ctx, Product request) {
    final entities = _state.products;
    final ids = entities.map((c) => c.id);
    if (entities.contains(request) || ids.contains(request.id)) {
      throw new UnsupportedError('Product already exists.');
    }
    entities.add(request);
    if (request.id == null || request.id == 0) {
      request.id = ids.isEmpty ? 1 : ids.reduce(max) + 1;
    }

    return new Future.value(request);
  }

  @override
  Future<Empty> deleteCompany(ClientContext ctx, Company request) {
    final entities = _state.companies;
    final ids = entities.map((c) => c.id);
    if (!entities.contains(request) && ids.contains(request.id)) {
      throw new UnsupportedError('Company does not exist.');
    }
    entities
      ..remove(request)
      ..retainWhere((e) => e.id == request.id);

    return new Future.value(new Empty());
  }

  @override
  Future<Empty> deleteOpportunity(ClientContext ctx, Opportunity request) {
    final entities = _state.opportunities;
    final ids = entities.map((c) => c.id);
    if (!entities.contains(request) && ids.contains(request.id)) {
      throw new UnsupportedError('Company does not exist.');
    }
    entities
      ..remove(request)
      ..retainWhere((e) => e.id == request.id);

    return new Future.value(new Empty());
  }

  @override
  Future<Empty> deleteProduct(ClientContext ctx, Product request) {
    final entities = _state.products;
    final ids = entities.map((c) => c.id);
    if (!entities.contains(request) && ids.contains(request.id)) {
      throw new UnsupportedError('Company does not exist.');
    }
    entities
      ..remove(request)
      ..retainWhere((e) => e.id == request.id);

    return new Future.value(new Empty());
  }

  @override
  Future<CompaniesResponse> getCompanies(ClientContext ctx, Empty request) {
    final response = new CompaniesResponse()
      ..companies.addAll(_state.companies);
    return new Future.value(response);
  }

  @override
  Future<Company> getCompany(ClientContext ctx, Company request) =>
      new Future.value(_state.companies.firstWhere((e) => e.id == request.id));

  @override
  Future<OpportunitiesResponse> getOpportunities(
      ClientContext ctx, Empty request) {
    final response = new OpportunitiesResponse()
      ..opportunities.addAll(_state.opportunities);
    return new Future.value(response);
  }

  @override
  Future<Opportunity> getOpportunity(ClientContext ctx, Opportunity request) =>
      new Future.value(
          _state.opportunities.firstWhere((e) => e.id == request.id));

  @override
  Future<Product> getProduct(ClientContext ctx, Product request) =>
      new Future.value(_state.products.firstWhere((e) => e.id == request.id));

  @override
  Future<ProductsResponse> getProducts(ClientContext ctx, Empty request) {
    final response = new ProductsResponse()..products.addAll(_state.products);
    return new Future.value(response);
  }

  @override
  Future<Company> updateCompany(ClientContext ctx, Company request) {
    final entity = _state.companies.firstWhere((e) => e.id == request.id)
      ..mergeFromBuffer(request.writeToBuffer());
    return new Future.value(entity);
  }

  @override
  Future<Opportunity> updateOpportunity(
      ClientContext ctx, Opportunity request) {
    final entity = _state.opportunities.firstWhere((e) => e.id == request.id)
      ..mergeFromBuffer(request.writeToBuffer());
    return new Future.value(entity);
  }

  @override
  Future<Product> updateProduct(ClientContext ctx, Product request) {
    final entity = _state.products.firstWhere((e) => e.id == request.id)
      ..mergeFromBuffer(request.writeToBuffer());
    return new Future.value(entity);
  }
}
