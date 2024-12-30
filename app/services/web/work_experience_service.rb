class Web::WorkExperienceService < ApplicationService
  def call
    work_experience_content
  end

  private

  def work_experience_content
    {
      es: {
        page_title: 'Experiencia Laboral',
        experiences: [
          {
            company: "Deviget",
            mode: "Contractor - Full time",
            client: "Ring LLC",
            start_date: "2022/June",
            end_date: "Actualidad",
            role: "Desarrollador Backend - Equipo de Suscripciones",
            stack: "Jira, Git, Sidekiq, Rails API, Aws SNS/SQS",
            logo: "/ring.png"
          },
          {
            company: "Loopstudio",
            mode: "Contractor - Full time",
            client: "Abstract US, SFR3, Techunited",
            start_date: "2019/Junio",
            end_date: "2022/Mayo",
            role: "Desarrollador Full Stack",
            stack: "Jira, Git, Sidekiq, Rails API, Heroku, React",
            logo: "/loopstudio.png"
          },
          {
            company: "Oyga!",
            mode: "Empleado - Full time",
            client: "",
            start_date: "2018/Enero",
            end_date: "2019/Mayo",
            role: "Desarrollador Full Stack",
            stack: "Javascript, Liquid, Git, Sidekiq, Rails API",
            logo: "/oyga.png"
          },
          {
            company: "Enronda",
            mode: "Ad-honorem",
            client: "N/A",
            start_date: "2024/Febrero",
            end_date: "2024/Agosto",
            role: "Asesor Tecnológico",
            stack: "Git, Rails 8, HTML, Fly.io, Calendly",
            logo: "/enronda.png"
          }
        ]
      },
      en: {
        page_title: 'Work Experience',
        experiences: [
          {
            company: "Deviget",
            mode: "Contractor - Full time",
            client: "Ring LLC",
            start_date: "2022/June",
            end_date: "Current",
            role: "Backend Developer - Subscriptions Team",
            stack: "Jira, Git, Sidekiq, Rails API, Aws SNS/SQS",
            logo: "/ring.png"
          },
          {
            company: "Loopstudio",
            mode: "Contractor - Full time",
            client: "Abstract US, SFR3, Techunited",
            start_date: "2019/June",
            end_date: "2022/May",
            role: "Full Stack Developer",
            stack: "Jira, Git, Sidekiq, Rails API, Heroku, React",
            logo: "/loopstudio.png"
          },
          {
            company: "Oyga!",
            mode: "Employee - Full time",
            client: "",
            start_date: "2018/January",
            end_date: "2019/May",
            role: "Full Stack Developer",
            stack: "Javascript, Git, Sidekiq, Rails API, Heroku",
            logo: "/oyga.png"
          },
          {
            company: "Enronda",
            mode: "Ad-honorem",
            client: "N/A",
            start_date: "2024/February",
            end_date: "2024/August",
            role: "Technology Advisor",
            stack: "Git, Rails 8, JS, HTML, Fly.io, Calendly.",
            logo: "/enronda.png"
          }
        ]
      }
    }
  end
end
