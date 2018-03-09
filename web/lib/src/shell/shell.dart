import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'shell',
    templateUrl: 'shell.html',
    styleUrls: const [
      'shell.css',
      'package:angular_components/app_layout/layout.scss.css',
    ],
    preserveWhitespace: false,
    directives: const [materialDirectives],
    providers: const [materialProviders])
class Shell {}
