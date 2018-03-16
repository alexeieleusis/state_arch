import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:protos/api.pb.dart';
import 'package:protos/entities.pb.dart';
import 'package:web/src/crm_api_service.dart';

@Component(
    selector: 'shell',
    templateUrl: 'shell.html',
    styleUrls: const [
      'shell.css',
      'package:angular_components/app_layout/layout.scss.css',
    ],
    preserveWhitespace: false,
    directives: const [CORE_DIRECTIVES, materialDirectives],
    providers: const [materialProviders])
class Shell implements OnInit {
  List<Company> companies = [];

  @override
  void ngOnInit() {
    final api = new CrmApiService();
    api.getCompanies(null, new Empty()).then((response) {
      companies = response.companies;
      companies.forEach(print);
    });
  }
}
